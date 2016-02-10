class ArticlesController < ApplicationController
	
	
	
	before_action :authenticate_user!, except: [:show, :index]
	before_action :set_article, except: [:index,:new,:create]
	before_action :check_auth, only: [:edit,:update,:destroy]

	
	def check_auth
		if session[:user_id] != @article.user_id
			#flash[:notice] = "Sorry, you can't update or delete this article"
			redirect_to(@article, :notice => "Not authorized!")
		end		
	end

	#GET /articles
	def index
		@articles = Article.paginate(page: params[:page],per_page:6)
	end
	#GET /articles/ :id
	def show
		@article.update_visits_count
		@comment = Comment.new
	end
	#GET /articles/new
	def new
		@article = Article.new
	end
	def edit
		
	end
	#PUT /articles/:id
	def update
		if @article.update(article_params)
			redirect_to @article
		else
			render :edit			
		end
	end
	#POST /articles
	def create
		@article = current_user.articles.new(article_params)
		if @article.save
		redirect_to @article
		else
			render :new
		end
		
	end
	def destroy
		@article.destroy
		redirect_to articles_path
	end
	private

	def set_article
		@article = Article.find(params[:id])
	
	end

	def article_params
		params.require(:article).permit(:title,:body,:cover)
	end

end