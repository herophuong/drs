class ReportTitlesController < ApplicationController
  # GET /report_titles
  # GET /report_titles.json
  def index
    @report_titles = ReportTitle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @report_titles }
    end
  end

  # GET /report_titles/1
  # GET /report_titles/1.json
  def show
    @report_title = ReportTitle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @report_title }
    end
  end

  # GET /report_titles/new
  # GET /report_titles/new.json
  def new
    @report_title = ReportTitle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @report_title }
    end
  end

  # GET /report_titles/1/edit
  def edit
    @report_title = ReportTitle.find(params[:id])
  end

  # POST /report_titles
  # POST /report_titles.json
  def create
    @report_title = ReportTitle.new(params[:report_title])

    respond_to do |format|
      if @report_title.save
        format.html { redirect_to @report_title, notice: 'Report title was successfully created.' }
        format.json { render json: @report_title, status: :created, location: @report_title }
      else
        format.html { render action: "new" }
        format.json { render json: @report_title.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /report_titles/1
  # PUT /report_titles/1.json
  def update
    @report_title = ReportTitle.find(params[:id])

    respond_to do |format|
      if @report_title.update_attributes(params[:report_title])
        format.html { redirect_to @report_title, notice: 'Report title was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @report_title.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /report_titles/1
  # DELETE /report_titles/1.json
  def destroy
    @report_title = ReportTitle.find(params[:id])
    @report_title.destroy

    respond_to do |format|
      format.html { redirect_to report_titles_url }
      format.json { head :no_content }
    end
  end
end
