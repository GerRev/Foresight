import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foresight_mobile/app/home/models/team.dart';
import 'package:foresight_mobile/widgets/platform_alert_dialog.dart';
import 'package:foresight_mobile/widgets/platform_exception_alert_dialog.dart';
import 'package:foresight_mobile/services/database.dart';
import 'package:flutter/services.dart';

class EditTeamPage extends StatefulWidget {
  const EditTeamPage({Key key, @required this.database, this.team}) : super(key: key);
  final Database database;
  final Team team;

  static Future<void> show(BuildContext context, {Team team}) async {
    final database = Provider.of<Database>(context,listen: false);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditTeamPage(database: database, team: team),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _EditTeamPageState createState() => _EditTeamPageState();
}

class _EditTeamPageState extends State<EditTeamPage> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  int _division;


  @override
  void initState() {
    super.initState();
    if (widget.team != null) {
      _name = widget.team.name;
      _division = widget.team.division;
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final teams = await widget.database.teamsStream().first;
        final allNames = teams.map((team) => team.name).toList();
        if (widget.team != null) {
          allNames.remove(widget.team.name);
        }
        if (allNames.contains(_name)) {
          PlatformDialog(
            title: 'Name already used',
            content: 'Please choose a different team name',
            defaultActionText: 'OK',
          ).show(context);
        } else {
          final id = widget.team?.id ?? docIdFromCurrentTime();
          final team = Team(id: id, name: _name, division: _division);
          await widget.database.setTeam(team);
          Navigator.of(context).pop();
        }
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Operation failed',
          exception: e,
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(widget.team == null ? 'New Team' : 'Edit Team'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18),
            ),
            onPressed: _submit,
          ),
        ],
      ),
      body: _buildContents(),
      backgroundColor: Colors.black54,
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Team name'),
        initialValue: _name,
        validator: (value) => value.isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (value) => _name = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Division'),
        initialValue: _division != null ? '$_division' : null,
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _division = int.tryParse(value) ?? 0,
      ),
    ];
  }
}
