package com.goodgamestudios.mafia.view.screens.dungeon
{
   import com.goodgamestudios.mafia.constants.enums.City;
   import com.goodgamestudios.mafia.model.MafiaModel;
   import flash.display.MovieClip;
   
   public class MafiaDungeonMapPositionSetter
   {
       
      
      public function MafiaDungeonMapPositionSetter()
      {
         super();
      }
      
      public static function firstMapPosition(param1:MovieClip, param2:int, param3:Number, param4:Number) : void
      {
         switch(MafiaModel.userData.gangwarData.city)
         {
            case City.NewYork:
               switch(param2)
               {
                  case 0:
                  case 1:
                  case 2:
                  case 3:
                     param1.x = 0;
                     param1.y = -(param4 * 2);
                     break;
                  case 4:
                  case 5:
                  case 6:
                  case 8:
                  case 7:
                     param1.x = 0;
                     param1.y = -param4;
                     break;
                  case 14:
                  case 15:
                     param1.x = -(param3 * 2);
                     param1.y = -(param4 * 2);
                     break;
                  case 17:
                  case 18:
                  case 16:
                     param1.x = -(param3 * 2);
                     param1.y = -param4;
                     break;
                  case 13:
                  case 12:
                  case 11:
                     param1.x = -param3;
                     param1.y = -param4;
                     break;
                  case 10:
                  case 9:
                     param1.x = -param3;
                     param1.y = 0;
               }
         }
      }
      
      public static function moveMap(param1:MovieClip) : void
      {
         switch(MafiaModel.userData.gangwarData.city)
         {
            case City.NewYork:
               if(param1.x >= 0)
               {
                  param1.x = -0.05;
               }
               if(param1.x < -400)
               {
                  param1.x = -399.95;
               }
               if(param1.y < -300)
               {
                  param1.y = -299.95;
               }
               if(param1.y >= 0)
               {
                  param1.y = -0.05;
               }
         }
      }
      
      public static function fitMap(param1:MovieClip) : void
      {
         switch(MafiaModel.userData.gangwarData.city)
         {
            case City.NewYork:
               param1.x = 0;
               param1.y = 0;
               param1.scaleX = param1.scaleY = 0.67;
               param1.fineLines.x = 0;
               param1.fineLines.y = 0;
               param1.fineLines.scaleX = param1.fineLines.scaleY = 1.5;
         }
      }
   }
}
