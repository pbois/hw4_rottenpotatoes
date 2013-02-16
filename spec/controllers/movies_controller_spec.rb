require 'spec_helper'

describe MoviesController do
  describe 'GET #similar_movies : Finding movies with same director' do
    before :each do
      @movie_id = '8'
      @similar_movies = [mock('movie1'), mock('movie2')]
      @movie = mock('movie0')
      Movie.stub(:find).and_return(@movie)
      Movie.stub(:find_all_by_director).and_return(@similar_movies)
      @movie.stub(:director).and_return('fake director')
    end
    it 'should search for similar movies' do
      Movie.should_receive(:find).with(@movie_id).and_return(@movie)
      Movie.should_receive(:find_all_by_director).with(@movie.director).and_return(@similar_movies)
      get :similar_movies, {:id => @movie_id}
    end
    context 'When similar movies are found' do
      it 'should select the "similar_movies" template for rendering' do
        get :similar_movies, {:id => @movie_id}
        response.should render_template 'similar_movies'
      end
      it 'should make the similar movies list available to the template' do
        get :similar_movies, {:id => @movie_id}
        assigns(:movies).should == @similar_movies
      end
    end
    context 'When no similar movie are found' do
      before do
        Movie.stub(:find_all_by_director).and_return([])
      end
      it 'should redirect to the home page' do
        get :similar_movies, {:id => @movie_id}
        response.should redirect_to(movies_path)
      end
    end
    context 'When no current movie are found' do
      before do
        Movie.stub(:find).and_return(nil)
      end
      it 'should redirect to the home page' do
        get :similar_movies, {:id => @movie_id}
        response.should redirect_to(movies_path)
      end
    end
    context 'When current movie has no director info' do
      before do
        @movie.stub(:director).and_return('')
        @movie.stub(:title).and_return('fake title')
      end
      it 'should redirect to the home page' do
        get :similar_movies, {:id => @movie_id}
        response.should redirect_to(movies_path)
      end
    end
  end
  describe 'create a new movie' do
    it 'should render the new-movie template' do
      get :new
      response.should render_template 'new'
    end
    it 'should call a model method to persist data' do
      movie = stub('new movie').as_null_object
      Movie.should_receive(:create!).and_return(movie)

      post :create, {:movie => movie}
    end
    it 'should render home template' do
      movie = stub('new movie').as_null_object
      Movie.stub(:create!).and_return(movie)

      post :create, {:movie => movie}
      response.should redirect_to(movies_path)
    end
  end

  describe 'delete an existing movie' do
    it 'should render edit movie template' do
      Movie.stub(:find)
      get :edit, {:id => 5}
      response.should render_template 'edit'
    end
    it 'should call a model method to update data' do
      my_movie = mock('a movie').as_null_object

      Movie.should_receive(:find).and_return(my_movie)
      my_movie.should_receive(:destroy)

      delete :destroy, {:id => 1}
    end
    it 'should render show details template' do

    end
  end


end
