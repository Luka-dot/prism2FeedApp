require('dotenv').config();

const {
    AUTH0_CLIENTID,
    AUTH0_DOMAIN,
    AUTH0_CLIENT_SECRET,
    AUTH0_SCOPE,
    AUTH0_COOKIE,
    BACKEND_ADDRESS
} = process.env;

module.exports = {
    publicRuntimeConfig: {
        BACKEND_URL: `{BACKEND_ADDRESS}/api/graphql`
    },
    serverRunTimeConfig: {
        auth: {
            domain: AUTH0_DOMAIN,
            clientId: AUTH0_CLIENTID,
            clientSecret: AUTH0_CLIENT_SECRET,
            scope: AUTH0_SCOPE,
            redirectUri: `${BACKEND_ADDRESS}/api/calback`,
            postLogoutRedirectUri: `${BACKEND_ADDRESS}/`
        },
        cookieSecret: AUTH0_COOKIE
    }
}