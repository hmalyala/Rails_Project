module MoviesHelper

    def verdict(movie)
        if movie.flop?
            "Flop"
        else
           number_to_currency(movie.total_gross, precision: 0)
        end
    end

end
