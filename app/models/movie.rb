class Movie < ApplicationRecord
    has_many :reviews,  dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :fans, through: :favorites, source: :user
    
    validates :title, :director, :duration, :rating, :total_gross, presence: true
	validates :description, length: {minimum: 25}
    validates :total_gross,  numericality: { greater_than_or_equal_to: 0}
    validates :image_file_name, format: {   
		with: /\w+\.(jpg|png)\z/i,   
		message: "must be a JPG or PNG image" 
    }

    def flop?
        total_gross.blank? || total_gross < 220000
    end

    def self.released
        Movie.where("released_on < ?", Time.now).order(released_on:  :desc)
    end

    def average_stars
        reviews.average(:stars) || 0.0
    end

end
