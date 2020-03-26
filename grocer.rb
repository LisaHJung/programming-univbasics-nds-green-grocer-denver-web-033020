require "pry"
require "pp"

def find_item_by_name_in_collection(string, array)
 item_index =0 
 while item_index < array.length 
  if array[item_index][:item] == string
    return array[item_index]
  end
  item_index+=1 
end
end

def consolidate_cart(cart)
  new_cart =[]
  item_index = 0 
  while item_index < cart.length do
    new_cart_item = find_item_by_name_in_collection(cart[item_index][:item], new_cart)
    if new_cart_item != nil
      new_cart_item[:count]+=1
    else 
      new_cart_item ={
        :item => cart[item_index][:item],
        :price => cart[item_index][:price],
        :clearance => cart[item_index][:clearance],
        :count => 1
      }
      new_cart << new_cart_item
    end
    item_index+=1 
  end
  new_cart
end

def apply_coupons(items_in_cart, coupon)
  item_index = 0
  while item_index < coupon.length do
    item_checked_coupon =find_item_by_name_in_collection(coupon[item_index][:item], items_in_cart)
    #binding.pry
    if item_checked_coupon != nil && items_in_cart[item_index][:count]>= coupon[item_index][:num]
      #binding.pry
      couponed_item ={
        :item => "#{items_in_cart[item_index][:item]} W/COUPON",
        :price =>coupon[item_index][:cost] /= coupon[item_index][:num],
        :clearance => items_in_cart[item_index][:clearance],
        :count => coupon[item_index][:num]
      }
      couponed_item_excess ={
        :item =>items_in_cart[item_index][:item],
        :price => items_in_cart[item_index][:price],
        :clearance => items_in_cart[item_index][:clearance],
        :count => items_in_cart[item_index][:count] - coupon[item_index][:num]
      }
      
    else 
      
      items_in_cart << couponed_item
      items_in_cart << couponed_item_excess
    end
  item_index+=1
end
items_in_cart
end

def apply_clearance (items_in_cart)
  cart_post_clearance =[]
  item_index =0 
  while item_index< items_in_cart.length
    if items_in_cart[item_index][:clearance] == true
      item_post_clearance = {
        :item => items_in_cart[item_index][:item],
        :price => items_in_cart[item_index][:price]* 0.8,
        :clearance => items_in_cart[item_index][:clearance],
        :count => items_in_cart[item_index][:count]
       }
      cart_post_clearance << item_post_clearance
    else
      cart_post_clearance << items_in_cart[item_index]
    end
  item_index +=1
  end
 cart_post_clearance 
end
=begin
def find_item_by_name_in_collection(name, collection)
  hash_index=0
  while hash_index<collection.length do
    if collection[hash_index][:item]==name
      return collection[hash_index]
      end
   hash_index+=1 
   end
end

def consolidate_cart(cart)
  new_cart = []
  hash_index = 0 
  while hash_index<cart.length do
    new_cart_item= find_item_by_name_in_collection(cart[hash_index][:item],new_cart)
    if new_cart_item != nil
      new_cart_item[:count] += 1 
    else 
      new_cart_item={
      :item=>cart[hash_index][:item], 
      :price=>cart[hash_index][:price],
      :clearance=>cart[hash_index][:clearance],
      :count => 1 
      }
      new_cart<< new_cart_item
    end
  hash_index+=1
  end
  new_cart
end

def apply_coupons(cart, coupons)
  item_index=0 
  while item_index<coupons.length do
    cart_item = find_item_by_name_in_collection(coupons[item_index][:item], cart)
    couponed_item_name = "#{coupons[item_index][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[item_index][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupon[item_index][:num]
        cart_item[:count]-= coupons[item_index][:num]
      else
        cart_item_with_coupon={
          :item => couponed_item_name,
          :price => coupons[item_index][:cost]/coupons[item_index][:num],
          :count => coupons[item_index][:num],
          :clearance => cart_item[:clearance],
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[item_index][:num]
      end
    end
    item_index+=1
    end
    cart
end


def apply_clearance(cart)
  item_index = 0 
  while item_index<cart.length
  if cart[item_index][:clearance] == true
    cart[item_index][:price] = (cart[item_index][:price]-(cart[item_index][:price] * 0.2)).round(2)
  end
  item_index+=1
end
cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  
  total=0 
  item_index =0 
  while item_index < final_cart.length
  total += final_cart[item_index][:price]* final_cart[item_index][:count]
  item_index+=1 
end
  if total> 100
    total-= (total*0.1)
  end
  total
end

=end

# Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
