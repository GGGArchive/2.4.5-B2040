package com.goodgamestudios.basic.view.screens
{
   import com.goodgamestudios.basic.event.LanguageDataEvent;
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.graphics.animation.SimplePreloadAnim;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class BasicIdleScreen extends BasicScreen
   {
       
      
      private var idleScreenBackground:Sprite;
      
      private var loadingAnimation:SimplePreloadAnim;
      
      public function BasicIdleScreen(param1:Sprite)
      {
         super(param1);
      }
      
      private function createScreenBackground() : void
      {
         this.idleScreenBackground = new Sprite();
         this.idleScreen.addChild(this.idleScreenBackground);
         this.drawBackground();
      }
      
      private function drawBackground() : void
      {
         this.idleScreenBackground.graphics.clear();
         this.idleScreenBackground.graphics.beginFill(0,0.5);
         this.idleScreenBackground.graphics.drawRect(0,0,disp.stage.stageWidth,disp.stage.stageHeight);
         this.idleScreenBackground.graphics.endFill();
      }
      
      override protected function applyProperties() : void
      {
         this.createScreenBackground();
         this.loadingAnimation = new SimplePreloadAnim();
      }
      
      override public function show() : void
      {
         super.show();
         this.idleScreenBackground.addChild(this.loadingAnimation);
      }
      
      override public function hide() : void
      {
         try
         {
            this.idleScreenBackground.removeChild(this.loadingAnimation);
            return;
         }
         catch(exp:ArgumentError)
         {
            return;
         }
         finally
         {
            super.hide();
         }
      }
      
      override protected function init() : void
      {
         BasicLanguageFontManager.getInstance().addEventListener(LanguageDataEvent.FONT_LOAD_START,this.showScreen);
         super.init();
      }
      
      override protected function onFontsLoaded(param1:LanguageDataEvent) : void
      {
         super.onFontsLoaded(param1);
         this.hide();
      }
      
      override protected function onResize(param1:Event) : void
      {
         this.drawBackground();
      }
      
      public function showScreen(param1:LanguageDataEvent) : void
      {
         this.show();
      }
      
      private function get idleScreen() : Sprite
      {
         return disp as Sprite;
      }
   }
}
