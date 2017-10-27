require 'rails_helper'

describe UsersController do
  describe 'admin access' do
    before :each do
      @user = create(:admin)
      session[:user_id] = @user.id
    end
    describe 'GET #index' do
      # ユーザーを @users に集めること
      it 'collects users into @users' do
        user = create(:user)
        get :index
        expect(assigns(:users)).to match_array [@user, user]
      end

      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #new' do
      # @contact に新しい連絡先を割り当てること
      it 'assigns a new User to @user' do
        get :new
        expect(assigns(:user)).to be_a_new(User)
      end
      # :new テンプレートを表示すること
      it 'renders the :new template' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do
      before :each do
        @user = attributes_for(:user)
      end

      # 有効な属性の場合
      context 'with valid attributes' do
        # データベースに新しいUserを保存すること
        it 'saves the new user in the database' do
          expect {
            post :create, user: @user
          }.to change(User, :count).by(1)
        end
        # contacts#show にリダイレクトすること
        it 'redirects to contacts#show' do
          post :create, user: @user
          expect(response).to redirect_to users_url
        end
      end
      # 無効な属性の場合
      context 'with invalid attributes' do
        # データベースに新しいユーザーを保存しないこと
        it 'does not save the new user in the database' do
          expect {
            post :create, user: attributes_for(:invalid_user)
          }.to_not change(User, :count)
        end
        # :new テンプレートを再表示すること
        it 're-renders the :new template' do
          post :create, user: attributes_for(:invalid_user)
          expect(response).to render_template :new
        end
      end
    end
  end

  describe 'user access' do
    before :each do
      @user = create(:user)
      session[:user_id] = @user.id
    end
    describe 'GET #index' do
      # ユーザーを @users に集めること
      it 'collects users into @users' do
        user = create(:user)
        get :index
        expect(assigns(:users)).to match_array [@user, user]
      end

      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end

    it 'GET #new denies access' do
      get :new
      expect(response).to redirect_to root_url
    end

    it 'POST#create denies access' do
      post :create, user: attributes_for(:user)
      expect(response).to redirect_to root_url
    end
  end
end
