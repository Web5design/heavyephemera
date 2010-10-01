/*
 *  TopBarController.mm
 *  ww
 *
 *  Created by jonbroFERrealz on 9/25/10.
 *  Copyright 2010 Heavy Ephemera Industries. All rights reserved.
 *
 */

#include "TopBarController.h"
#include "MainController.h"

void TopBarController::setup(){
	background.loadImage("images/topbar.png");
	background.setImageType(OF_IMAGE_COLOR_ALPHA);
	
	stateImages[0].loadImage("images/blank.png");
	stateImages[0].setImageType(OF_IMAGE_COLOR_ALPHA);
	stateImages[1].loadImage("images/wire.png");
	stateImages[1].setImageType(OF_IMAGE_COLOR_ALPHA);
	stateImages[2].loadImage("images/spark.png");
	stateImages[2].setImageType(OF_IMAGE_COLOR_ALPHA);
	stateImages[3].loadImage("images/tail.png");
	stateImages[3].setImageType(OF_IMAGE_COLOR_ALPHA);
	
	stateControl.setPosAndSize(5, 5, 114, 36);
	stateControl.removeListeners();
	
	playImages[0].loadImage("images/play_false.png");
	playImages[0].setImageType(OF_IMAGE_COLOR_ALPHA);
	playImages[1].loadImage("images/play_true.png");
	playImages[1].setImageType(OF_IMAGE_COLOR_ALPHA);

	playControl.setPosAndSize(279, 5, 34, 34);
	playControl.removeListeners();
	
	toSpeed.setPosAndSize(279-40, 4, 34, 34);
	toSpeed.removeListeners();
	
	toSynthImage.loadImage("images/to_synths.png");
	toSynthImage.setImageType(OF_IMAGE_COLOR_ALPHA);
	toSynthControl.setPosAndSize(0, 445, 42, 44);
	toSynthControl.removeListeners();
	atSynthList = false;
	interstate.loadFont("InterstatePlusBold.ttf", 10);
}
bool TopBarController::hitTest(ofTouchEventArgs &touch)
{
	return toSynthControl.hitTest(touch);
}

void TopBarController::draw(){
	ofSetColor(255, 255, 255);
	background.draw(0, 0);
	stateImages[rootModel->currentState].draw(5, 5);
	if (rootModel->running) {
		playImages[1].draw(279, 5);
	}else {
		playImages[0].draw(279, 5);
	}
	string bpm_clock = ofToString(rootModel->bpm, 0)+"X"+ofToString(rootModel->clockMult, 0);
	interstate.drawString(bpm_clock, 279-interstate.stringWidth(bpm_clock)-10, 26);
	if (!atSynthList) {
		toSynthImage.draw(0, 445);
	}
}
void TopBarController::update(){
}
void TopBarController::touchDown(ofTouchEventArgs &touch)
{
	if (stateControl.hitTest(touch) && !atSynthList) {
		rootModel->currentState = (rootModel->currentState+1)%4;
	}
	if (playControl.hitTest(touch)) {
		rootModel->running = !(rootModel->running);
	}
	if (toSpeed.hitTest(touch)) {
		mainController->changeScreen("speed");
	}
	if (toSynthControl.hitTest(touch)){
		atSynthList = !atSynthList;
		if (!atSynthList) {
			rootModel->linkingSynths = false;
			toSynthControl.setPosAndSize(0, 438, 42, 44);
			mainController->changeScreen("scroller");
		}else{
			rootModel->linkingSynths = true;
			toSynthControl.setPosAndSize(150, 438, 42, 44);
			mainController->changeScreen("synth_list");
		}
	}
}