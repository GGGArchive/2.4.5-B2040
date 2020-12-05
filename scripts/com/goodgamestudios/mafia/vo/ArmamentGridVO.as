package com.goodgamestudios.mafia.vo
{
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   
   public class ArmamentGridVO
   {
       
      
      public var width:uint;
      
      public var height:uint;
      
      public var gridMap:Vector.<Vector.<ItemVO>>;
      
      public var unlockCost:int;
      
      public var isUnlockable:Boolean;
      
      public var nextPaidUnlockLevel:uint;
      
      public var nextFreeUnlockLevel:uint;
      
      public function ArmamentGridVO()
      {
         super();
      }
   }
}
