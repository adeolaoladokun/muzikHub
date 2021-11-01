class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:index]

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
  	   @total_revenue = Transaction.where(status: 'Paid').sum(:platform_amount)
  	   @total_creator_payout = Transaction.where(status: 'Paid').sum(:creator_amount)
  	   @total_payment = Transaction.where(status: 'Paid').sum(:amount)
  	   #@transactions = Song.joins(:transactions)
  	   @transactions = Transaction.all
	   logger.debug("Total Transaction is #{@total_revenue.round}")
	   logger.debug("User ID is #{@account_owner}")


	   if @user.fan_role == true
			transaction = Transaction.new(:trxn_reference => @txn_ref, :amount => 450000, :payment_date => DateTime.now, :song_id => 1, :user_id => @account_owner, :status => 'Initiated')
			if transaction.save!
	   				logger.debug("I got here now with transaction #{transaction['trxn_reference']}")

			end
	   		
	   end





  end
end
