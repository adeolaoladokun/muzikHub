class TransactionsController < ApplicationController
   require 'httparty'
    
    skip_before_action :verify_authenticity_token, :only => [:verify_transactions]

	def verify_transactions
		txn_reference = params[:reference]
		headers = { 
  		"Content-Type"  => "application/json",
  		"Authorization" => "Bearer sk_test_a18d989117519e3ac64b574291657d9b1f2031c2" 
		}
		endpoint = "https://api.paystack.co/transaction/verify/#{txn_reference}"
    	logger.debug("Transaction endpoint send to paystack is #{endpoint}")
		@response = HTTParty.get(endpoint,:headers => headers)
    	verification_data = JSON.parse(@response.body)
    	logger.debug("Transaction data is #{verification_data}")
    	if @response.code == 200 && verification_data['data']['status'] == 'success' 
    		platform_amount = verification_data['data']['fees_split']['integration'].round
    		creator_amount = verification_data['data']['fees_split']['subaccount'].round
    		paystack_charge = verification_data['data']['fees_split']['paystack'].round
    	    Transaction.where(:trxn_reference => txn_reference).update_all({:status => "Paid", :platform_amount => platform_amount, :creator_amount => creator_amount, :payment_provider_amount => paystack_charge})
			redirect_to(user_transactions_path, :notice => 'Transaction Successful')	
    	end

	end
	def user_transaction
		user_id = current_user.id
		@user_transactions = Transaction.where(user_id: user_id)
		logger.debug("Users Transactions are #{@user_transactions}")
	end
end
