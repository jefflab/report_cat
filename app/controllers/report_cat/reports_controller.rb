module ReportCat
  class ReportsController < ApplicationController

    layout :set_layout

    before_filter :_authenticate!
    before_filter :_authorize!
    before_filter :set_reports

    def index
    end

    def show
      @report = @reports[ params[ :id ] ]
      @report.back = params[ :back ]
      @report.generate( params )

      respond_to do |format|
        format.html
        format.csv { render :text => @report.to_csv, :content_type => 'text/csv' }
      end
    end

  protected

    def set_reports
      @reports = ReportCat.reports
    end

    def set_layout
      return ReportCat.config.layout
    end

    def _authenticate!
      instance_eval( &ReportCat.config.authenticate_with )
    end

    def _authorize!
      instance_eval( &ReportCat.config.authorize_with )
    end

  end
end
