class UsersController < ApplicationController
	before_action :authenticate_user!
  def edit

  end

  def update
  	current_user.update(user_params)

  	redirect_back(fallback_location: root_path) 
  	#redireccióna para la pagina de la que venia y fallback es la ruta q se va a producir si no hay una pagina a la que ir antes
  end

  def user_params
  	params.require(:user).permit(:avatar)
  end

end
