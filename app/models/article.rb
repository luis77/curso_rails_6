class Article < ApplicationRecord
	has_rich_text :content
	belongs_to :user #el belongs_to va en la tabla a la que se le pone user_id
	has_many :has_categories
	has_many :categories, through: :has_categories
	attr_accessor :category_elements #me permite definir una propiedad que puedo leer y escribir

	def save_categories
		#category_elements q es un string de ids 1,2,3
		#convertir eso en un arreglo 1,2,3 => [1,2,3]
			#como se cambio el selectbox por un multiple checkbox ya no sera string sino un arreglo xq permitira seleccionar varios y ya no sera necesario convertirlo a arreglo
			#categories_array = category_elements.split(",") #con split separamos un string con el separador a se le diga, en este caso la ',' y separar cada elemento con ',' en un arreglo
		#iterar ese arreglo
			return has_categories.destroy_all if category_elements.nil? || category_elements.empty? #para que no de error si no se selecciona ninguna

			has_categories.where.not(category_id: category_elements).destroy_all 
			#has_categories devuelve todas las cat del articulo. where.not es el inverso del where y devuelve los elementos que no coincidan con las condiciones que coloquemos 
			#y le podemos pasar un arreglo, en este caso category_elements

			#categories_array.each do |category_id| cambiado xq ya recibimos un array directamente
			category_elements.each do |category_id|
				#por cada elemento del arreglo crear un registro en la tabla asociativa 
				#o sea Crear HasCategory HasCategor<article_id: 1, category_id: 2>
			
			 #	unless HasCategory.where(article:self,category_id: category_id).any?
					#amenos(unless es el inverso del if) que de verdadero el codigo de aquí adentro no se ejecuta
			 #		HasCategory.create(article: self,category_id: category_id)#self hace referencia al articulo
			 #	end
			 #tambien se puede usar find_or_create_by
			 	HasCategory.find_or_create_by(article: self,category_id: category_id)#self hace referencia al articulo
		
			end
	end


end
