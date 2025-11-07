import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';
import '../services/api_service.dart';

class AuditListScreen extends StatefulWidget {
  const AuditListScreen({super.key});

  @override
  State<AuditListScreen> createState() => _AuditListScreenState();
}

class _AuditListScreenState extends State<AuditListScreen> {
  late Future<List<Audit>> _auditList;
  String? _token;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await _getToken();
    _refreshAudits();
  }

  Future<void> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
    });
  }

  void _refreshAudits() {
    setState(() {
      _auditList = ApiService.getAudit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audit List')),
      body: _token == null
          ? const Center(child: Text('Loading...'))
          : FutureBuilder<List<Audit>>(
              future: _auditList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text('Loading audits...'));
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No audits found'));
                }

                final audits = snapshot.data!;
                return ListView.builder(
                  itemCount: audits.length,
                  itemBuilder: (context, index) {
                    final audit = audits[index];
                    return ListTile(
                      title: Text('Action: ${audit.action ?? 'N/A'}'),
                      subtitle: Text('Logs: ${audit.activity_log}'),
                    );
                  },
                );
              },
            ),
    );
  }
}
