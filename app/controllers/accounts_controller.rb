class AccountsController < ApplicationController
  require 'httparty'

  skip_before_action :verify_authenticity_token, :only => [:create]

  def create
  	@user = current_user.id
  	bank_code = params[:bank_code]
  	account_number = params[:account_number]

  	#verify the account number
  	headers = { 
  		"Content-Type"  => "application/json",
  		"Authorization" => "Bearer sk_test_a18d989117519e3ac64b574291657d9b1f2031c2" 
		}

	verify_endpoint = 'https://api.paystack.co/bank/resolve?account_number='+account_number+'&bank_code='+bank_code
	logger.debug("Account verification endpoint is #{verify_endpoint}")
	@verify_response = HTTParty.get(verify_endpoint,:headers => headers)
    verify_data = JSON.parse(@verify_response.body)
    logger.debug("Verification Response is #{@verify_response.code}")
	if @verify_response.code == 200 && account_number.to_s == verify_data['data']['account_number']
			endpoint = 'https://api.paystack.co/subaccount'
		  	@response = HTTParty.post(endpoint,
		      :body => {    
		                :business_name => "Mavin Records",
		                :bank_code => "#{bank_code}",
		                :account_number => "#{account_number}",
		                :percentage_charge => 98}.to_json, 
		      :headers => headers)
			
			
		    user_data = JSON.parse(@response.body)
			logger.debug("#{user_data}")
			account = Account.new
			logger.debug("Account is #{account}")
			account.business_name = user_data['data']['business_name']
			account.account_number = user_data['data']['account_number']
			account.percentage_charge = user_data['data']['percentage_charge']
			account.settlement_bank = user_data['data']['settlement_bank']
			account.subaccount_code = user_data['data']['subaccount_code']
			account.is_verified = user_data['data']['is_verified']
			account.active = user_data['data']['active']
			account.createdat = user_data['data']['createdAt']
			account.updatedat = user_data['data']['updatedAt']
			account.user_id = @user
			account.currency = user_data['data']['currency']

			# set name value however you want to do that
			if account.save
				redirect_to(root_path, :notice => 'Account successfully created')
			end		
	end
	
    
	

  end

  def show
  end

  
end
