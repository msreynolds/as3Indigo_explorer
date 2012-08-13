/**
 * Created with IntelliJ IDEA.
 * User: mreynolds
 * Date: 7/19/12
 * Time: 9:53 PM
 * To change this template use File | Settings | File Templates.
 */
package com.perceptiveautomation.indigo.trigger.view {
import com.perceptiveautomation.indigo.trigger.IIndigoTrigger;

import flash.events.MouseEvent;

import spark.components.Label;
import spark.components.supportClasses.ItemRenderer;
import spark.events.ListEvent;

public class IndigoTriggerListItemRenderer extends ItemRenderer {

    // Child Display Objects
    private var _labelTriggerName:Label;
    private var _labelTriggerFolder:Label;
    private var _labelTriggerType:Label;

    private var _indigoTrigger:IIndigoTrigger;

    public function IndigoTriggerListItemRenderer() {
        this.height = 28;
        this.doubleClickEnabled = true;
        this.addEventListener(MouseEvent.DOUBLE_CLICK, handleMouseDoubleClick);
    }

    override public function set data(value:Object):void {
        super.data = value;

        if (value is IIndigoTrigger) {
            _indigoTrigger = value as IIndigoTrigger;
        }
    }

    override protected function createChildren():void {
        super.createChildren();

        if (!_labelTriggerName) {
            _labelTriggerName = new Label();
            _labelTriggerName.text = (_indigoTrigger !== null) ? _indigoTrigger.name : "Name Not Available";
            _labelTriggerName.left = 7;
            _labelTriggerName.top = 9;
            this.addElement( _labelTriggerName );
        }

        if (!_labelTriggerType) {
            _labelTriggerType = new Label();
            _labelTriggerType.text = (_indigoTrigger !== null) ? _indigoTrigger.type : "-";
            _labelTriggerType.horizontalCenter = 0;
            _labelTriggerType.top = 9;
            this.addElement( _labelTriggerType );
        }

        if (!_labelTriggerFolder) {
            _labelTriggerFolder = new Label();
            _labelTriggerFolder.text = (_indigoTrigger !== null) ? _indigoTrigger.folder : "-";
            _labelTriggerFolder.right = 7;
            _labelTriggerFolder.top = 9;
            this.addElement( _labelTriggerFolder );
        }

    }

    override protected function commitProperties():void {
        super.commitProperties();
        _labelTriggerName.text = (_indigoTrigger !== null) ? _indigoTrigger.name : "Name Not Available";
        _labelTriggerType.text = (_indigoTrigger !== null) ? _indigoTrigger.type : "-";
        _labelTriggerFolder.text = (_indigoTrigger !== null) ? _indigoTrigger.folder : "-";

    }

    private function handleMouseDoubleClick(event:MouseEvent):void {
        var listEvent:ListEvent = new ListEvent("showItemDetail",false,false,NaN,NaN,null,false,false,false,false,0,-1,this.data, this);
        this.owner.dispatchEvent(listEvent);
    }

}
}
