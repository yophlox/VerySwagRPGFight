package states;

import flixel.FlxState;
import flixel.addons.display.shapes.FlxShapeBox;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxSprite;
import game.Ty;

class PlayState extends FlxState
{
    final actions:Array<String> = ['Fight him', 'Bribe him with cookies (yay)', 'Nerd out with him', 'Leave'];
    var dialogue:String = 'Woah is that Ty from uh twitter dot com?!?';
    public var box:FlxShapeBox;
    public var actionTexts:Array<FlxText>;
    private var selectedIndex:Int = 0;
    private var selector:FlxText;
    private var dialogueText:FlxText;
	private var seenCookiedialogue:Bool = false;
	private var triedCookies:Int = 0;
	var timer:FlxTimer = new FlxTimer();
	public var Tyy:Ty;

    override public function create()
    {
		Tyy = new Ty(100, 100, "Ty");
		Tyy.data.health = 64; // haha sm64 reference
		Tyy.data.maxHealth = 25;
		Tyy.data.attack = 5;
		Tyy.data.defense = 1;
		Tyy.data.xpReward = 10;
		Tyy.data.goldReward = 2;

		var tySprite:FlxSprite = new FlxSprite(0,0);
		tySprite.loadGraphic("assets/images/placeholder.png");
//		tySprite.loadGraphic("assets/images/" + Tyy.data.name + ".png");
		tySprite.screenCenter(Y);
		tySprite.scale.set(0.3, 0.3);
		add(tySprite);


        box = new FlxShapeBox(740, 170, 370, 270, {thickness: 6, jointStyle: MITER, color: FlxColor.WHITE}, FlxColor.BLACK);
        box.scrollFactor.set();
        box.active = false;
        add(box);

        dialogueText = new FlxText(box.x + 10, box.y + 10, box.width - 20, dialogue);
        dialogueText.setFormat("assets/fonts/vcr.ttf", 18, FlxColor.WHITE, "center");
        dialogueText.scrollFactor.set();
        add(dialogueText);

        actionTexts = [];
        for (i in 0...actions.length)
        {
            var actionText = new FlxText(box.x + 30, box.y + 70 + (i * 50), box.width - 40, actions[i]); // Moved text down more
            actionText.setFormat("assets/fonts/vcr.ttf", 16, FlxColor.WHITE, "left"); // Changed alignment to left
            actionText.scrollFactor.set();
            actionTexts.push(actionText);
            add(actionText);
        }

        selector = new FlxText(box.x + 10, box.y + 70, 20, ">");
        selector.setFormat("assets/fonts/vcr.ttf", 16, FlxColor.WHITE, "left");
        selector.scrollFactor.set();
        add(selector);

        super.create();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.UP)
        {
            selectedIndex = (selectedIndex - 1 + actions.length) % actions.length;
        }
        else if (FlxG.keys.justPressed.DOWN)
        {
            selectedIndex = (selectedIndex + 1) % actions.length;
        }
		if (FlxG.keys.justPressed.ENTER)
		{
			switch (actions[selectedIndex])
			{
				case 'Fight him':
					// battle system here 
				case 'Bribe him with cookies (yay)':
					if (triedCookies != 20)
					{
						triedCookies ++;
						trace(triedCookies);
						dialogue = "Ty refused the cookies";
						timer.start(2.5, resetDialogue, 1);

					}
					else if (!seenCookiedialogue && triedCookies == 20)
					{
						seenCookiedialogue = true;
						dialogue = "You successfully gave Ty the cookies, you're friends now :D";
						dialogueText.text = dialogue;
					}
					else if (seenCookiedialogue)
					{
						//FlxG.switchState(new EndState());
					}
			}
		}
        selector.y = box.y + 70 + (selectedIndex * 50);
    }

	private function resetDialogue(timer:FlxTimer):Void {
		dialogue = "Woah is that Ty from uh twitter dot com?!?";
		dialogueText.text = dialogue;
	}
}
