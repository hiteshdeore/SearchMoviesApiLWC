/*
------------------------------------------------------------------------------------------------------------------------------------------
Below Class is Created For Search Movie Lists Through TMDB API 
------------------------------------------------------------------------------------------------------------------------------------------
*/
Global class themoviedbJSON2Apex {
	
    /* Api Call For Serching Movies Via query */
    @AuraEnabled
    public static List<MovieList> makeAPICall(String query) {
        String endpoint = 'https://api.themoviedb.org/3/search/movie?query=' + query + '&include_adult=false&language=en-US&page=1';
        return makeAPICallInternal(endpoint);
    }
	
    /* Api Call For Popular Movies */
    @AuraEnabled
    public static List<MovieList> makeAPICallPopularMovies() {
        String endpoint = 'https://api.themoviedb.org/3/movie/popular?language=en-US&page=1';
        return makeAPICallInternal(endpoint);
    }

    private static List<MovieList> makeAPICallInternal(String endpoint) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response;
        
        /* Created Custom Setting for Storing authorizationHeader */
       Map<String, TMDB__c> tmdbSettings = TMDB__c.getAll();
            if (tmdbSettings == null || tmdbSettings.isEmpty()) {
                System.debug('TMDB custom setting is missing');
                return new List<MovieList>();
            }
            
            String authorizationHeader = tmdbSettings.get('authorizationHeader').authorizationHeader__c;

            if (String.isBlank(authorizationHeader)) {
                System.debug('Authorization Header is blank');
                return new List<MovieList>();
				}
   
             /* You Can Also use below method if you dont want store Access Token in Custom Setting
			 String authorizationHeader='Bearer TmdbAccesToken';
			*/
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        request.setHeader('accept', 'application/json');
        request.setHeader('Authorization','Bearer '+authorizationHeader);
  
        try {
            response = http.send(request);

            if (response.getStatusCode() == 200) {
                TheMovieDBResponse movieListResponse = (TheMovieDBResponse) JSON.deserialize(response.getBody(), TheMovieDBResponse.class);
                
                if (movieListResponse != null && movieListResponse.results != null && !movieListResponse.results.isEmpty()) {
                    return movieListResponse.results;
                }
            } else {
                handleAPIError(response);
            }
        } catch (System.CalloutException e) {
            System.debug('HTTP Request Exception: ' + e.getMessage());
        } catch (JsonException e) {
            System.debug('JSON Exception: ' + e.getMessage());
        }

        return new List<MovieList>();
    }
    
    private static void handleAPIError(HttpResponse response) {
        System.debug('HTTP Error: ' + response.getStatusCode() + ' - ' + response.getStatus());
        // Add custom error handling logic here or throw custom exceptions
    }

    public class TheMovieDBResponse {
        public List<MovieList> results;
    }

    public class MovieList {
        @AuraEnabled
        public String original_language;

        @AuraEnabled
        public String overview;

        @AuraEnabled
        public Double vote_average;

        @AuraEnabled
        public Double id;

        @AuraEnabled
        public String poster_path;

        @AuraEnabled
        public String release_date;

        @AuraEnabled
        public String title;
    }
}
