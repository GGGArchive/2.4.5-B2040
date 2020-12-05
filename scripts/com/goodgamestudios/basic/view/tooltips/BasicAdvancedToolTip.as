package com.goodgamestudios.basic.view.tooltips
{
   import com.goodgamestudios.basic.EnvGlobalsHandler;
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.view.FlashUIComponent;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class BasicAdvancedToolTip extends FlashUIComponent
   {
      
      public static const NAME:String = "BasicAdvancedToolTip";
       
      
      private var _dispBounds:Rectangle;
      
      public function BasicAdvancedToolTip(param1:DisplayObject)
      {
         this._dispBounds = param1.getBounds(null);
         super(param1);
      }
      
      public function get dispBounds() : Rectangle
      {
         return this._dispBounds;
      }
      
      protected function get env() : IEnvironmentGlobals
      {
         return EnvGlobalsHandler.globals;
      }
   }
}
