 # -*- encoding : utf-8 -*-

class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml
  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    
    def image_request(query)
		
		def key
			key = "968209f2bf611505726a78b71b47f411";
		end

		require "net/http"
		require "net/https"
		
		uri = URI.parse("http://api.flickr.com")
		http = Net::HTTP.new(uri.host, uri.port)

		request = "/services/rest/?method=flickr.photos.search&per_page=10&format=json&nojsoncallback=1&api_key=" + key + "&text=" + query
		
		# нужно профиксить ситуацию маленького кол-ва результатов
		response = JSON(http.request(Net::HTTP::Get.new(request)).body)["photos"]["photo"][rand(9)]
		
		response.nil? ? "" : "http://farm#{response["farm"]}.static.flickr.com/#{response["server"]}/#{response["id"]}_#{response["secret"]}_m.jpg"
	
	end
	
    @product = Product.new
    	
	respond_to do |format|
        format.html
        format.js {
	
			if !params["name"].empty?
				require "cgi"
		
				@image_url = image_request(CGI.escape(params["name"]))
			
			end
		 
			
		} 
    end




  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])
	@product.save 
	
    respond_to do |format|
      format.js  
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end
end
