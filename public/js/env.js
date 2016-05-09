(function (window) {
    window.__env = window.__env || {};
    var host = 'http://localhost:3000';
    window.__env.apiUrl = host == 'undefined' ? 'http://localhost:3000' : host;
}(this));