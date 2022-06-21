class ThingsController < ApplicationController
    def show
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: '請求書', #pdfファイルの名前。これがないとエラーが出ます
                 layout: 'application', #レイアウトファイルの指定。views/layoutsが読まれます。                 
                 encording: 'UTF-8',
                 template: 'things/show.html.erb' #テンプレートファイルの指定。viewsフォルダが読み込まれます。
        end
      end
    end
  end