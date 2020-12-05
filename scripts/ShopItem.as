package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class ShopItem extends MovieClip
   {
       
      
      public var amount:MovieClip;
      
      public var txt_cost:TextField;
      
      public var itemSize:ShopItemSize;
      
      public var holder:emptyMC;
      
      public var lock:MovieClip;
      
      public var price:MovieClip;
      
      public function ShopItem()
      {
         super();
      }
   }
}
