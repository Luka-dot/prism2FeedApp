/*
  Warnings:

  - The migration will change the primary key for the `BundleTag` table. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `is` on the `BundleTag` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `Feed` table. All the data in the column will be lost.
  - The migration will change the primary key for the `FeedTag` table. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `is` on the `FeedTag` table. All the data in the column will be lost.
  - Added the required column `id` to the `BundleTag` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `FeedTag` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Feed" DROP CONSTRAINT "Feed_userId_fkey";

-- DropForeignKey
ALTER TABLE "_BundleToBundleTag" DROP CONSTRAINT "_BundleToBundleTag_B_fkey";

-- DropForeignKey
ALTER TABLE "_FeedToFeedTag" DROP CONSTRAINT "_FeedToFeedTag_B_fkey";

-- AlterTable
ALTER TABLE "Bundle" ALTER COLUMN "description" SET DEFAULT E'';

-- AlterTable
ALTER TABLE "BundleTag" DROP CONSTRAINT "BundleTag_pkey",
DROP COLUMN "is",
ADD COLUMN     "id" TEXT NOT NULL,
ADD PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "Feed" DROP COLUMN "userId";

-- AlterTable
ALTER TABLE "FeedTag" DROP CONSTRAINT "FeedTag_pkey",
DROP COLUMN "is",
ADD COLUMN     "id" TEXT NOT NULL,
ADD PRIMARY KEY ("id");

-- CreateTable
CREATE TABLE "_BundleToFeed" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_BundleToFeed_AB_unique" ON "_BundleToFeed"("A", "B");

-- CreateIndex
CREATE INDEX "_BundleToFeed_B_index" ON "_BundleToFeed"("B");

-- AddForeignKey
ALTER TABLE "_BundleToFeed" ADD FOREIGN KEY ("A") REFERENCES "Bundle"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_BundleToFeed" ADD FOREIGN KEY ("B") REFERENCES "Feed"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_BundleToBundleTag" ADD FOREIGN KEY ("B") REFERENCES "BundleTag"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_FeedToFeedTag" ADD FOREIGN KEY ("B") REFERENCES "FeedTag"("id") ON DELETE CASCADE ON UPDATE CASCADE;
