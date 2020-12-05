package com.goodgamestudios.mafia.view.screens.firstVisit
{
   import com.goodgamestudios.basic.view.firstVisit.FirstVisitToolTipManager;
   import flash.display.MovieClip;
   import flash.filters.DropShadowFilter;
   
   public class MafiaFirstVisitToolTipManager extends FirstVisitToolTipManager
   {
       
      
      public function MafiaFirstVisitToolTipManager(param1:MovieClip)
      {
         super(param1);
      }
      
      override public function set toolTip(param1:MovieClip) : void
      {
         param1.filters = [new DropShadowFilter(3,45,0,0.5,5,5)];
         super.toolTip = param1;
      }
   }
}
