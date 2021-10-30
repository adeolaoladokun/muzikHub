class HomeController < ApplicationController
  def index
  	   @user = current_user    
  	   @account_owner = @user.id
  	   @account = Account.find_by(user_id: current_user.id)
	   #logger.debug("Account is #{@account.active}")
  	   @songs = Song.where(user_id: current_user.id)
	   @test_pub_key = "pk_test_e8b1026ad787f2ac2df0b50e54e222469f49a459"
  	   creator_account = Account.find_by(user_id: 6)
  	   @creator_subaccount = creator_account['subaccount_code']
  	   #@creator_subaccount = creator_account['subaccount_code'].to_s
  	   @txn_ref = SecureRandom.hex(10)
	   logger.debug("Account is #{@creator_subaccount}")




  end
end
