import { LightningElement, track } from 'lwc';
import makeApiCall from '@salesforce/apex/themoviedbJSON2Apex.makeAPICall';
import PopularMovies from '@salesforce/apex/themoviedbJSON2Apex.makeAPICallPopularMovies';
import noHeader from '@salesforce/resourceUrl/NoHeader';
import { loadStyle } from 'lightning/platformResourceLoader';

export default class MovieListApp extends LightningElement {
    @track moviesData;
    @track query = '';
    @track isLoading = false;
    moviePosterUrl = '';
    posterPath = '';

    connectedCallback() {
        this.loadNoHeaderStyle();
        this.loadPopularMovies();
    }

    loadNoHeaderStyle() {
        loadStyle(this, noHeader)
            .then(result => {})
            .catch(error => {
                console.error('Error loading NoHeader style:', error);
            });
    }

    loadPopularMovies() {
        PopularMovies()
            .then(data => {
                this.isLoading = false;
                this.moviesData = data;
                this.updateMoviePosterUrls();
            })
            .catch(error => {
                console.error('Error loading popular movies:', error);
            });
    }

    handleChange(event) {
        this.query = event.target.value;
        console.log(this.query);
    }

    handleSearch(event) {
        this.isLoading = true;

        makeApiCall({ query: this.query })
            .then(data => {
                this.isLoading = false;
                this.moviesData = data;
                this.updateMoviePosterUrls();
            })
            .catch(error => {
                console.error('Error searching movies:', error);
            });
    }

    updateMoviePosterUrls() {
        if (this.moviesData && this.moviesData.length > 0) {
            this.moviesData = this.moviesData.map(movie => ({
                ...movie,
                moviePosterUrl: this.constructImageUrl(movie.poster_path),
            }));
        }
    }

    constructImageUrl(posterPath) {
        if (posterPath) {
            return 'https://image.tmdb.org/t/p/w500' + posterPath;
        }
        return '';
    }

    get isNoMoviesFound() {
        return this.moviesData && this.moviesData.length === 0;
    }
}
