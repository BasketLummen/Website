class QueryString {

    constructor () {}

    get (name, url) {
        if (!url)
            url = window.location.href;
        
        name = name.replace(/[\[\]]/g, "\\$&");
        
        const regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)");
        const results = regex.exec(url);
        
        if (!results) 
            return null;
        if (!results[2])
            return '';
        
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    }
}

const queryString = new QueryString();
export { queryString }