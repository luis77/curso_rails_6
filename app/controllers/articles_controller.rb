class ArticlesController < ApplicationController
	before_action :find_article, except: [:new,:create,:index,:from_author]
	before_action :authenticate_user!, only: [:new,:create,:edit,:update,:destroy]

	def index
		@articles = Article.all	
	end

	def show
	end

	def edit
		@categories = Category.all
	end

	def update
		@article.update(article_params)
		@article.save_categories#metodo del modelo para guardar la relacion muchos a muchos de articuls y categorias
		redirect_to @article
	end

	def new
		@article = Article.new
		@article.title = 'Demo' #se llena title con demo
		@categories = Category.all

	end

	def create
		@article = current_user.articles.create(article_params)		
		@article.save_categories#metodo del modelo para guardar la relacion muchos a muchos de articuls y categorias
		#tambien para la asignacion de usuario se puede hacer de dos formas
		#@article.user_id = current_user.id #estaríamos guardando el articulo dos veces
		#o
		#@article.user = current_user #se le puede asignar el objeto completamente y rails sabra que tiene q guardar el id en el campo apropiado
		#@article.save #guarda todos los cambios q se le ha hecho al usuario, o sea el añadido de usuario

		redirect_to @article #envia el articulo creado x json
	end

	def destroy
		@article.destroy
		redirect_to root_path		
	end

	def from_author
		@user = User.find(params[:user_id])
	end

	def find_article
		@article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title,:content,category_elements: [])#le decimos a los strong params los campos que estan permitidos
		#category_elements: [] para que sepa que debe esperar un arreglo
	end

end
