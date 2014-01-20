require 'mail'

module CheeseyDelivery
	
# sample CheeseyDelivery call
# CheeseyDelivery.send!({
# 	:data=>{'first_name'=>'Dsquarious'}, 
# 	:to_email=>"hi@markhayden.me", 
# 	:from_email=>"hi+from@markhayden.me", 
# 	:from_name=>"Mark Hayden", 
# 	:subject=>"Hey look, I use liquid!", 
# 	:template=>"sample"
# })

	OPTIONS = {
				:enable_starttls_auto => CheeseyConfig[:cheesey_mailer][:enable_starttls_auto],
				:address => CheeseyConfig[:cheesey_mailer][:address],
				:port => CheeseyConfig[:cheesey_mailer][:port],
				:domain => CheeseyConfig[:cheesey_mailer][:domain],
				:user_name => CheeseyConfig[:cheesey_mailer][:user_name],
				:password => CheeseyConfig[:cheesey_mailer][:password],
				:authentication => CheeseyConfig[:cheesey_mailer][:authentication]
		    }

	# render the template from the main template directory using liquid. all variables are passed from data object
	def self.render_template(template, pkt)
		@template = Liquid::Template.parse(File.read("#{CheeseyConfig[:cheesey_mailer][:template_directory]}/#{template}.html")).render('data'=>pkt)
		return @template
	end

	# render the text version of the template from the main template directory using liquid. all variables are passed from data object
	def self.render_txt(template, pkt)
		@template = Liquid::Template.parse(File.read("#{CheeseyConfig[:cheesey_mailer][:template_directory]}/#{template}.txt")).render('data'=>pkt)
		return @template
	end

	# send the email!
	def self.send!(pkt)
		Mail.defaults do
			delivery_method :smtp, OPTIONS
		end

		begin
			if CheeseyConfig[:cheesey_mailer][:send] == true
				mail = Mail.deliver do
					to pkt[:to_email]
					from "#{pkt[:from_name]} <#{pkt[:from_email]}>"
					subject pkt[:subject]

					text_part do
						body CheeseyDelivery.render_txt(pkt[:template], pkt[:data])
					end

					html_part do
						content_type 'text/html; charset=UTF-8'
						body CheeseyDelivery.render_template(pkt[:template], pkt[:data])
					end
				end
				mail.deliver!
				LOG.debug "[EMAIL SENT] Cheesey mailer has a delivery on the way. <TMP:#{pkt[:template]} TO:#{pkt[:to_email]} SUBJECT:#{pkt[:subject]}>"
			else
				html_header = "To: #{pkt[:to_email]}<br/>From: #{pkt[:from_name]}<br/>Subject: #{pkt[:subject]}"
				File.open("#{CheeseyConfig[:cheesey_mailer][:render_direcotry]}/#{pkt[:template]}-#{pkt[:to_email]}.html", 'w+') {|f| 
					f.write(
						"<div style='padding:15px 25px; margin-bottom:20px; background:#CCC; width:100%; font-size:18px;'>#{html_header}</div>#{CheeseyDelivery.render_template(pkt[:template], pkt[:data])}"
					)
				}; true

				txt_header = "To: #{pkt[:to_email]}\nFrom: #{pkt[:from_name]}\nSubject: #{pkt[:subject]}"
				File.open("#{CheeseyConfig[:cheesey_mailer][:render_direcotry]}/#{pkt[:template]}-#{pkt[:to_email]}.txt", 'w+') {|f| 
					f.write(
						"#{txt_header}\n\n#{CheeseyDelivery.render_txt(pkt[:template], pkt[:data])}"
					)
				}; true

				LOG.debug "[EMAIL SAVED] Cheesey mailer has a LOCAL delivery on the way. <TMP:#{pkt[:template]} TO:#{pkt[:to_email]} SUBJECT:#{pkt[:subject]}>"
			end
			return true
		rescue
			LOG.error "[EMAIL FAILED] Cheesey mailer dropped the ball. An email has failed. <TMP:#{pkt[:template]} TO:#{pkt[:to_email]} SUBJECT:#{pkt[:subject]}>"
			return false
		end
	end
end