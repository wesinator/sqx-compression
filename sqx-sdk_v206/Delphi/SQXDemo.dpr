program SQXDemo;

uses
  Forms,
  SQXDemoUnit in 'SQXDemoUnit.pas' {SQXForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TSQXForm, SQXForm);
  Application.Run;
end.
