/**
 * Created with IntelliJ IDEA.
 * User: mreynolds
 * Date: 7/19/12
 * Time: 9:53 PM
 * To change this template use File | Settings | File Templates.
 */
package com.perceptiveautomation.indigo.view.components {
import com.perceptiveautomation.indigo.schedule.IIndigoSchedule;

import flash.events.MouseEvent;

import spark.components.Label;
import spark.components.supportClasses.ItemRenderer;
import spark.events.ListEvent;

public class IndigoScheduleListItemRenderer extends ItemRenderer{

    // Child Display Objects
    private var _labelScheduleName:Label;
    private var _labelScheduleDescription:Label;
    private var _labelScheduleFolder:Label;
    private var _labelScheduleNextExecution:Label;

    private var _indigoSchedule:IIndigoSchedule;

    public function IndigoScheduleListItemRenderer() {
        this.height = 28;
        this.doubleClickEnabled = true;
        this.addEventListener(MouseEvent.DOUBLE_CLICK, handleMouseDoubleClick);
    }

    override public function set data(value:Object):void {

        if (value is IIndigoSchedule) {
            _indigoSchedule = value as IIndigoSchedule;
        }
    }

    override protected function createChildren():void {
        super.createChildren();

        if (!_labelScheduleName) {
            _labelScheduleName = new Label();
            _labelScheduleName.text = (_indigoSchedule !== null) ? _indigoSchedule.name : "Name Not Available";
            _labelScheduleName.left = 7;
            _labelScheduleName.top = 9;
            this.addElement( _labelScheduleName );
        }

        if (!_labelScheduleDescription) {
            _labelScheduleDescription = new Label();
            _labelScheduleDescription.text = (_indigoSchedule !== null) ? _indigoSchedule.description : "-";
            _labelScheduleDescription.horizontalCenter = -25;
            _labelScheduleDescription.top = 9;
            this.addElement( _labelScheduleDescription );
        }

        if (!_labelScheduleFolder) {
            _labelScheduleFolder = new Label();
            _labelScheduleFolder.text = (_indigoSchedule !== null) ? _indigoSchedule.folder : "-";
            _labelScheduleFolder.horizontalCenter = 25;
            _labelScheduleFolder.top = 9;
            this.addElement( _labelScheduleFolder );
        }

        if (!_labelScheduleNextExecution) {
            _labelScheduleNextExecution = new Label();
            _labelScheduleNextExecution.text = (_indigoSchedule !== null) ? _indigoSchedule.nextExecuteDate : "-";
            _labelScheduleNextExecution.right = 7;
            _labelScheduleNextExecution.top = 9;
            this.addElement( _labelScheduleFolder );
        }

    }

    override protected function commitProperties():void {
        super.commitProperties();
        _labelScheduleName.text = (_indigoSchedule !== null) ? _indigoSchedule.name : "Name Not Available";
        _labelScheduleDescription.text = (_indigoSchedule !== null) ? _indigoSchedule.description : "-";
        _labelScheduleFolder.text = (_indigoSchedule !== null) ? _indigoSchedule.folder : "-";
        _labelScheduleNextExecution.text = (_indigoSchedule !== null) ? _indigoSchedule.nextExecuteDate : "-";

    }

    private function handleMouseDoubleClick(event:MouseEvent):void {
        var listEvent:ListEvent = new ListEvent("showItemDetail",false,false,NaN,NaN,null,false,false,false,false,0,-1,this.data, this);
        this.owner.dispatchEvent(listEvent);
    }

}
}
