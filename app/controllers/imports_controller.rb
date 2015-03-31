class ImportsController < ApplicationController
  def index
    
  end

  def new
    
  end

  def create
    @datas = GenerateParseDataService.call({
      if: params[:if].path,
      fs: params[:fs].path
    })

    render xlsx: 'create'
  end
end
