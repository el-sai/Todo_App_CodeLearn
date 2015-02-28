class TodosController < ApplicationController
  def index
  	#@todo_item = "Learn ROR"
  	#@todo_list = ["Learn Ruby","Learn Rails","Take Test","Go to Colombia"]
  	@todo_list = Todo.all
  	@todo = Todo.new
  end
  
  def delete
  	@id = params[:format]
  	Todo.find(@id).destroy
  	redirect_to index_path
  end
  
  def add
  	@task = user_params[:todo_item]
  	t = Todo.create(:todo_item => @task)
  	if t.valid?
  		flash[:success] = "Your Todo Task has been added successfully"
  	else
  		flash[:error] = t.errors.full_messages.join("<br>")
  	end
  	redirect_to index_path
  end
  
  def complete
  	id = params[:todos_checkbox]
  	if id
  		id.each do |i|
  			t = Todo.find(i)
  			t.completed = true
  			t.save
  		end
  	else
  		flash[:msg] = "Please check a task to mark it completed"
    end
    		redirect_to index_path
  end
  
  private
  
   def user_params
      params.require(:todo).permit(:todo_item)
    end
  
end
