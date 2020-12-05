package com.goodgamestudios.mafia.vo
{
   import com.goodgamestudios.mafia.constants.enums.CharacterClass;
   import com.goodgamestudios.mafia.vo.items.ItemVO;
   import flash.geom.Point;
   
   public class MissionVO
   {
       
      
      public var missionNr:Number;
      
      public var missionID:Number;
      
      public var difficulty:int;
      
      public var enemyID:int;
      
      public var c1:Number;
      
      public var xp:Number;
      
      public var ap:Number;
      
      public var cIcon:CharacterClass;
      
      public var time:Number;
      
      public var item:ItemVO;
      
      public var name:String;
      
      public var staticPosition:Point;
      
      public function MissionVO()
      {
         super();
      }
   }
}
