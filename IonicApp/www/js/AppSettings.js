AppSettings = {
  // @if ENV == 'DEVELOPMENT'
  baseApiUrl: 'http://localhost:8000/',
  debug: true
  // @endif
  // @if ENV == 'TEST'
  baseApiUrl: 'http://localhost:8000/'
  // @endif
  // @if ENV == 'PRODUCTION'
  baseApiUrl: 'https://diinner.herokuapp.com'
  // @endif
}