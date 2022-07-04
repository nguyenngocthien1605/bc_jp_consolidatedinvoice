pageextension 50108 "Payment Terms SGS" extends "Payment Terms" //4
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {

            field("CutOff Day"; Rec."CutOff Day")
            {
                ApplicationArea = All;
            }
            // field("Num Of Days"; Rec."Num Of Days")
            // {
            //     ApplicationArea = All;
            // }
            // field("Num Of Months"; Rec."Num Of Months")
            // {
            //     ApplicationArea = All;
            // }
            field("Payment Day"; Rec."Payment Day")
            {
                ApplicationArea = All;
            }
        }
    }
    // actions
    // {
    //     addlast(processing)
    //     {
    //         group("Process")
    //         {
    //             action(TestDueDate)
    //             {
    //                 ApplicationArea = All;

    //                 trigger OnAction()
    //                 begin
    //                     Dialog.Message('Test due date!');
    //                 end;
    //             }
    //         }
    //     }
    // }

}