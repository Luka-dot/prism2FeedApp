import { initAuth0 } from '@auth0/nextjs-auth0'

import getConfig from 'next/config'
const{serverRuntimeConfig} = getConfig();

export default initAuth0({
  
})