package com.goodgamestudios.mafia.view
{
   import com.goodgamestudios.basic.IEnvironmentGlobals;
   import com.goodgamestudios.basic.model.BasicModel;
   import com.goodgamestudios.basic.view.BasicBackgroundComponent;
   import com.goodgamestudios.basic.view.BasicCustomCursor;
   import com.goodgamestudios.basic.view.BasicLanguageFontManager;
   import com.goodgamestudios.language.countryMapper.GGSCountryController;
   import com.goodgamestudios.mafia.MafiaEnvironmentGlobals;
   import com.goodgamestudios.mafia.constants.Constants_Basic;
   import com.goodgamestudios.misc.SupportUtil;
   import com.goodgamestudios.utils.BrowserUtil;
   import flash.events.MouseEvent;
   
   public class MafiaBackgroundComponent extends BasicBackgroundComponent
   {
       
      
      public function MafiaBackgroundComponent(param1:MafiaTitle)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         customCursor = new BasicCustomCursor(new CursorGfx());
         customCursor.init();
         this.mafiaTitle.stage.addChild(customCursor.disp);
         if(BrowserUtil.getBrowserName().indexOf("IE") >= 0 && this.env.loginIsKeyBased)
         {
            customCursor.hideForPerformance();
         }
         this.updatePosition();
      }
      
      override public function updatePosition() : void
      {
         var _loc1_:Number = NaN;
         if(background && background.stage)
         {
            if(this.env.hasNetworkBuddies)
            {
               background.scaleX = background.scaleY = background.stage.stageWidth / Constants_Basic.GAME_WIDTH;
            }
            else
            {
               background.scaleX = background.scaleY = background.stage.stageHeight / 600;
            }
            _loc1_ = background.scaleX;
            background.x = (background.stage.stageWidth - Constants_Basic.GAME_WIDTH * background.scaleX) * 0.5;
            background.y = 0;
            progressBar.x = (background.stage.stageWidth - Constants_Basic.GAME_WIDTH * background.scaleX) * 0.5 + Constants_Basic.GAME_WIDTH * _loc1_ * 0.5 - progressBar.width * 0.5;
            backgroundView.txt_progress.x = progressBar.x + progressBar.width / 6;
            progressBar.y = 500 * _loc1_;
            backgroundView.txt_progress.y = progressBar.y - backgroundView.txt_progress.height * 0.5;
            progressBar.scaleX = progressBar.scaleY = backgroundView.txt_progress.scaleX = backgroundView.txt_progress.scaleY = _loc1_ / 1.2;
         }
         if(!BasicLanguageFontManager.getInstance().useDefaultFont)
         {
            disp.scaleY = disp.scaleY * 1.0001;
         }
      }
      
      override public function updateLoadingProgress(param1:Number) : void
      {
         if(progressBar.visible)
         {
            progressBar.bar.scaleX = param1 * 0.01;
            backgroundView.txt_progress.text = param1 + "%";
         }
      }
      
      override public function hideProgressBar() : void
      {
         progressBar.visible = false;
         backgroundView.txt_progress.text = "";
      }
      
      override protected function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case supportBtn:
               SupportUtil.navigateToSupport(this.env.gameId,BasicModel.instanceProxy.selectedInstanceVO.instanceId,this.env.versionText,this.env.networkId,this.env.gameTitle,"-",-1,-1,GGSCountryController.instance.currentCountry.ggsLanguageCode,this.env.referrer);
         }
      }
      
      override public function startProgressBar() : void
      {
         super.startProgressBar();
         this.updatePosition();
      }
      
      public function showSFSProgress(param1:String) : void
      {
         progressBar.visible = true;
         progressBar.bar.scaleX = 1;
         backgroundView.txt_progress.visible = true;
         backgroundView.txt_progress.text = param1;
      }
      
      override public function destroy() : void
      {
         trace("MafiaBackgroundComponent destroy");
      }
      
      private function get mafiaTitle() : MafiaTitle
      {
         return disp as MafiaTitle;
      }
      
      override protected function get env() : IEnvironmentGlobals
      {
         return new MafiaEnvironmentGlobals();
      }
   }
}
