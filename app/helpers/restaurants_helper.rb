# encoding: UTF-8
module RestaurantsHelper

 def display_bool(bool_dat)
   if bool_dat then
     return 'o'
   else
     return 'x'
   end
 end

 def display_reservation(reservation_dat)
     if reservation_dat then
         return '予約OK'
    else
         return '予約NG'
    end
 end
    
end
