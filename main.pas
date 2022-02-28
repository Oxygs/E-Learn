unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, DBCtrls, ComCtrls, StrUtils , FileUtil, Types;

type

  { TMainForm }

  TMainForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    Shape1: TShape;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    StatusBar1: TStatusBar;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    function Extrait_titre(chaine : string ) : string ;
    procedure SpeedButton2Click(Sender: TObject);
  private

  public

  end;

var
  MainForm: TMainForm;

implementation

{$R *.frm}

{ TMainForm }

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
       if MessageDlg('Fermer cette application  ?', mtConfirmation, [mbOk, mbCancel], 0) = mrCancel then  CanClose := False else canClose := True;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
     StatusBar1.Panels[0].Text:= DateToStr(Now()) + ' - ' + TimeToStr(Now());
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);

var fichier_defaut : string ;
    reponse : Boolean ;
begin

      reponse := OpenDialog1.execute;

      if reponse then
      begin
           fichier_defaut := OpenDialog1.FileName;

           Image2.Picture.LoadFromFile(fichier_defaut) ;

           Edit1.Text := fichier_defaut ;
       end ;
      shape1.Brush.color := clRed;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
    Application.MainForm.Close ;
end;

procedure TMainForm.Button2Click(Sender: TObject);
var repertoire, destination : string ;
begin
     if ( ( Length(trim(edit1.text)) <> 0 ) and ( Length(trim(edit2.text)) <>0))then
     begin
          Shape1.Brush.color := clGreen ;
          StatusBar1.Panels[1].Text:= '';
          repertoire := ExtractFileDir(opendialog1.FileName);
          destination := edit2.text + '/defaut.jpg' ;
          CopyFile(edit1.text , destination);
          StatusBar1.Panels[1].Text:='Le Tips a été appliqué...' ;
          Shape1.brush.color := clred ;
     end
     else
     begin
          Shape1.brush.color := clRed ;
          StatusBar1.Panels[1].Text:=' Attention il manque des valeurs source et repertoire destination...';
     end;

end;

procedure TMainForm.Button2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if ( ( Length(trim(edit1.text)) <> 0 ) and ( Length(trim(edit2.text)) <>0)) then shape1.brush.color := clgreen else shape1.brush.color := clred ;
  StatusBar1.panels[1].text := '';
end;

// Extrait la première ligne comme titre du tips
Function TMainForm.extrait_titre(chaine : String ) : String ;
var combien : integer ;
    dernier_mot : String ;
begin
            combien := WordCount(chaine,[';']);
            dernier_mot := ExtractWord(combien,chaine,[ ';' ]);
            result := dernier_mot ;
end;

procedure TMainForm.SpeedButton2Click(Sender: TObject);
var rep_destination : String ;
    selection_dir : boolean ;
begin
    shape1.brush.color := clRed;
    selection_dir := SelectDirectoryDialog1.Execute;
    if selection_dir then
    begin
        Edit2.Text:= SelectDirectoryDialog1.FileName;
    end;
end;

end.
