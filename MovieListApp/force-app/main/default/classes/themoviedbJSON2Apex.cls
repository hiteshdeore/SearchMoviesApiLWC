/*
------------------------------------------------------------------------------------------------------------------------------------------
Below Class is Created For Search Movie Lists Through TMDB API 
------------------------------------------------------------------------------------------------------------------------------------------
*/
Global class themoviedbJSON2Apex {
    
    @AuraEnabled
    public static MovieList makeAPICall(String query) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        HttpResponse response;
        
        String endpoint = 'https://api.themoviedb.org/3/search/movie?query='+query+'&include_adult=false&language=en-US&page=1';
                          
        String authorizationHeader = 'Bearer Your Access Token Auth';
        
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        request.setHeader('accept', 'application/json');
        request.setHeader('Authorization', authorizationHeader);
        
 try {
            response = http.send(request);
            

            if (response.getStatusCode() == 200) {
                TheMovieDBResponse movieListResponse = (TheMovieDBResponse) JSON.deserialize(response.getBody(), TheMovieDBResponse.class);
                System.debug('MovieList Response: ' + movieListResponse);
                
                if (movieListResponse != null && movieListResponse.results != null && movieListResponse.results.size() > 0) {
                    return movieListResponse.results[0];
                }
            } else {
                System.debug('HTTP Error: ' + response.getStatusCode() + ' - ' + response.getStatus());
            }
        } catch (Exception e) {
            System.debug('Exception: ' + e.getMessage());
        }

        return null;
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
