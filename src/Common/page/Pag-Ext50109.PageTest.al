pageextension 50109 "PageTest" extends "Customer List"
{
    trigger OnOpenPage()
    var
        Msg: Label 'Last business date of month %1 is %2';
        DateMgt: Codeunit "Date Function Mgt";
    begin

        // Message(Msg, 1, DateMgt.getLastBusinessDate(31, 1, 2022));
        // Message(Msg, 2, DateMgt.getLastBusinessDate(31, 2, 2022));
        // Message(Msg, 3, DateMgt.getLastBusinessDate(31, 3, 2022));
        // Message(Msg, 4, DateMgt.getLastBusinessDate(31, 4, 2022));
        // Message(Msg, 5, DateMgt.getLastBusinessDate(31, 5, 2022));
        // Message(Msg, 6, DateMgt.getLastBusinessDate(31, 6, 2022));
        // Message(Msg, 7, DateMgt.getLastBusinessDate(31, 7, 2022));
        // Message(Msg, 8, DateMgt.getLastBusinessDate(31, 8, 2022));
        // Message(Msg, 9, DateMgt.getLastBusinessDate(31, 9, 2022));
        // Message(Msg, 10, DateMgt.getLastBusinessDate(31, 10, 2022));
        // Message(Msg, 11, DateMgt.getLastBusinessDate(31, 11, 2022));
        // Message(Msg, 12, DateMgt.getLastBusinessDate(31, 12, 2022));

    end;

}
