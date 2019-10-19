require 'rails_helper'

describe MoviesController, type: :controller do

  describe '#similar_movies' do
    context 'when a director is found' do
      it "should return a list of movies with the same director" do
        my_movie = double('Movie', :id => '1', :title => 'Alien', :director => 'Spielberg')
        expect(Movie).to receive(:find).with('1').and_return(my_movie)
        expect(my_movie.director).to eql 'Spielberg'
        expect(Movie).to receive(:where).with(director: 'Spielberg')
        get :similar_movies, {:id => 1}
      end
    end

     context 'when a director is not found' do
      it "should redirect to the home page" do
        my_movie = double('Movie', :id => '1', :title => 'Alien', :director => nil)
        expect(Movie).to receive(:find).with('1').and_return(my_movie)
        get :similar_movies, {:id => "1"}
        expect(flash[:notice]).to match(/'Alien' has no director info/)
        expect(response).to redirect_to(movies_path)
      end
    end

    end

    describe ".show" do
        it 'show a movie by id' do
            Movie.create(title: 'Movie1', rating: 'G', 
                director: 'Director1', release_date: Date.new(2003,10,10))
            get :show, id: 1
            expect(response).to render_template('movies/show')
        end
    end

    describe ".edit" do
        it 'edit a movie by id' do
            Movie.create(title: 'Movie1', rating: 'G', 
                director: 'Director1', release_date: Date.new(2003,10,10))
            get :edit, id: 1
            expect(response).to render_template('movies/edit')
        end
    end

    describe ".create" do
        it "creates a movie" do
            movie_p = Hash.new
            movie_p["title"] = "Movie1"
            movie_p["rating"] = "G"
            movie_p["director"] = "Director1"
            movie_p["release_date"] = Date.new(2003,10,10)
            post :create, movie: movie_p
            expect(response).to redirect_to("/movies")
            expect{Movie.create(title: "An Lee", director: 'name')}.to change{Movie.count}.by(1)

        end
    end

    describe ".update" do
        it "updates a movie" do
            Movie.create(title: 'Movie1', rating: 'G', director: 'Director1', release_date: Date.new(2003,10,10))
            movie_p = Hash.new
            movie_p["title"] = "Movie1"
            movie_p["rating"] = "G"
            movie_p["director"] = "Director1"
            movie_p["release_date"] = Date.new(2003,10,10)

            movie = Movie.all.where(id: 1).take
            get :update, id: 1, movie: movie_p

            expect(response).to redirect_to("/movies/#{movie.id}")
        end
    end

    describe ".index" do
        it "sorts by title" do
            get :index, sort: "title"
        end
    end

    describe "#destroy" do
        it "should delete a post" do
        Movie.create(title: 'Movie1', rating: 'G', director: 'Director1', release_date: Date.new(2003,10,10))
        expect {delete :destroy, id: '1'}.to change(Movie, :count).by(-1)
        end

    describe "#new" do
    it "should assigns a new post to @post" do
      get :new
    end
  end
  end
end