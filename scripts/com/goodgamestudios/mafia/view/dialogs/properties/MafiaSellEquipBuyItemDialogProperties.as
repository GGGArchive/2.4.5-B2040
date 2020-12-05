package com.goodgamestudios.mafia.view.dialogs.properties
{
   import com.goodgamestudios.basic.view.BasicProperties;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   
   public class MafiaSellEquipBuyItemDialogProperties extends BasicProperties
   {
      
      public static const MODE_SELL:int = 1;
      
      public static const MODE_BUY:int = 2;
      
      public static const MODE_EQUIP:int = 3;
       
      
      public var item:ItemVO;
      
      public var mode:int;
      
      public var functionYes:Function;
      
      public var functionNo:Function;
      
      public function MafiaSellEquipBuyItemDialogProperties(param1:ItemVO, param2:int, param3:Function = null, param4:Function = null)
      {
         super();
         this.item = param1;
         this.mode = param2;
         this.functionYes = param3;
         this.functionNo = param4;
      }
   }
}
