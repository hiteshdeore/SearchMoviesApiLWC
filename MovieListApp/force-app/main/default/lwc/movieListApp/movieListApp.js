import { LightningElement, track } from 'lwc';
import makeApiCall from '@salesforce/apex/themoviedbJSON2Apex.makeAPICall';

//Import your CSS-File from the Static Resources
import noHeader from '@salesforce/resourceUrl/NoHeader';
//Import loadStyle-Method
import {loadStyle} from "lightning/platformResourceLoader";

export default class MovieListApp extends LightningElement {
    @track moviesData;
    @track query = '';
    @track isLoading = false;
    moviePosterUrl = '';
    posterPath = '';

    connectedCallback() {
        loadStyle(this, noHeader)
            .then(result => {});
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
                console.log('Data:::' + JSON.stringify(this.moviesData));

                // Loop over each movie and update the poster path
                this.moviesData.forEach(movie => {
                    movie.moviePosterUrl = this.constructImageUrl(movie.poster_path);
                });
            })
            .catch(err => console.log(err));
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