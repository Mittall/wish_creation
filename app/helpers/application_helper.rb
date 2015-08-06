module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    
    if direction == "asc"
      title = image_tag("down_arrow.gif") + " " + title.to_s
    else  
      title = image_tag("up_arrow.gif") + " " + title.to_s
    end  
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), :class => direction, :remote => true
  end  
  
  def get_model_data(m, cemetery=false)
    if cemetery
      [["Select", ""]] + m.constantize.active.where(:cemetery_id => @cemetery.id).collect {|r| [r.name, r.id]}
    else
      [["Select", ""]] + m.constantize.active.collect {|r| [r.name, r.id]}
    end    
  end
  
  def get_all_pages
    FooterPage.footer 
  end
  
  def get_marital_status
    [["Select", ""]] + [["Never Married", "Never Married"]] + [["Married", "Married"]] + [["Widow/Widower", "Widow/Widower"]] + [["Separated but not divorced", "Separated but not divorced"]] + [["Divorced", "Divorced"]] + [["De facto", "De facto"]] + [["Unknow", "Unknow"]] 
  end
  
  def get_pager_numbers
    [["10", 10]] + [["20", 20]] + [["30", 30]] + [["40", 40]] + [["50", 50]]
  end
  
  def get_user_roles
    Role.all.collect {|r| [r.role_type, r.id]} 
  end      
   
def paypal_url(return_url ,carts) 
		values = { 
		:business => 'mittal.vitrainee@gmail.com',
   		:cmd => '_cart',
		:upload => 1,
		:return => return_url,
		}	
	
	total_qty = 0 

			carts.each_with_index do |item, index|   
				total = item.product.price.to_i   
				values.merge!({
		       "amount_#{index+1}" => total,
		       "item_name_#{index+1}" => item.get_product_name(item.product.id),
		       "item_number_#{index+1}" => item.id,
		       "quantity_#{index+1}" => item.qty
	     })   
			end
	 	
   	      # For test transactions use this URL
		"https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
	end 	
end
