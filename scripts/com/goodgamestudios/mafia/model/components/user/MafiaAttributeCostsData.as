package com.goodgamestudios.mafia.model.components.user
{
   import com.goodgamestudios.basic.controller.BasicController;
   import com.goodgamestudios.mafia.event.model.MafiaUserEvent;
   
   public class MafiaAttributeCostsData
   {
       
      
      public var attackCost:Number;
      
      public var enduranceCost:Number;
      
      public var luckCost:Number;
      
      public var resistanceCost:Number;
      
      public var freeAttributes:int;
      
      public function MafiaAttributeCostsData()
      {
         super();
      }
      
      public function parseData(param1:Array) : void
      {
         var _loc3_:Object = null;
         param1.shift();
         var _loc2_:Array = new Array();
         for each(_loc3_ in String(param1).split("+"))
         {
            _loc2_.push(_loc3_);
         }
         this.attackCost = _loc2_.shift();
         this.enduranceCost = _loc2_.shift();
         this.luckCost = _loc2_.shift();
         this.resistanceCost = _loc2_.shift();
         this.freeAttributes = _loc2_.shift();
         BasicController.getInstance().dispatchEvent(new MafiaUserEvent(MafiaUserEvent.CHANGE_OWN_USER_ATTRIBUTE_COSTS_DATA));
      }
   }
}
