package com.goodgamestudios.mafia.view.screens.survival
{
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.mafia.view.screens.MafiaScreen;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MafiaSurvivalComponent extends MafiaScreen
   {
       
      
      public function MafiaSurvivalComponent(param1:DisplayObject, param2:Boolean = true)
      {
         super(param1,false);
      }
      
      public function toForeground() : void
      {
         this.hellComponent.mouseChildren = true;
         this.hellComponent.parent.setChildIndex(this.hellComponent,this.hellComponent.parent.numChildren - 1);
         this.hellComponent.deselectionLayer.visible = false;
         this.hellComponent.useHandCursor = false;
         this.hellComponent.buttonMode = false;
         layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
      }
      
      public function toBackground() : void
      {
         this.hellComponent.mouseChildren = false;
         this.hellComponent.deselectionLayer.visible = true;
      }
      
      override public function updatePosition() : void
      {
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         if(this.hellComponent.mouseChildren == false)
         {
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_CLICK);
            this.hellComponent.useHandCursor = true;
            this.hellComponent.buttonMode = true;
         }
         super.onMouseOver(param1);
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         if(this.hellComponent.mouseChildren == false)
         {
            layoutManager.customCursor.setCursorType(BasicCustomCursor.CURSOR_ARROW);
            this.hellComponent.useHandCursor = false;
            this.hellComponent.buttonMode = false;
         }
         super.onMouseOut(param1);
      }
      
      protected function get hellComponent() : MovieClip
      {
         return disp as MovieClip;
      }
   }
}
