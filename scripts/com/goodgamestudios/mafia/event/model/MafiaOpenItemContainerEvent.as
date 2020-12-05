package com.goodgamestudios.mafia.event.model
{
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   
   public class MafiaOpenItemContainerEvent extends MafiaEvent
   {
      
      public static const CONTAINER_OPENED:String = "container_opened";
       
      
      public var containerType:String;
      
      public var containerSlotId:uint;
      
      public var item:ItemVO;
      
      public function MafiaOpenItemContainerEvent(param1:String, param2:String, param3:ItemVO, param4:uint, param5:Array = null, param6:Boolean = false, param7:Boolean = false)
      {
         super(param1,param5,param6,param7);
         this.containerType = param2;
         this.item = param3;
         this.containerSlotId = param4;
      }
   }
}
