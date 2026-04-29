import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/validators.dart';
import '../../../shared/models/site_model.dart';
import '../../../shared/widgets/app_button.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey    = GlobalKey<FormState>();
  final _emailCtrl  = TextEditingController();
  final _passCtrl   = TextEditingController();
  bool  _obscure    = true;
  SiteModel? _selectedSite;

  late AnimationController _fadeCtrl;
  late Animation<double>   _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn);
    _fadeCtrl.forward();

    // Charger les sites dès l'ouverture
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthProvider>().loadSites();
    });
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    final ok = await context.read<AuthProvider>().login(
      _emailCtrl.text.trim(),
      _passCtrl.text,
      _selectedSite?.id,
    );

    if (ok && mounted) {
      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final auth   = context.watch<AuthProvider>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF111827), AppColors.darkBg]
                : [AppColors.lightSurface2, AppColors.lightBg],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ── Logo ──────────────────────────────────
                    Container(
                      width: 60, height: 60,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.cyan],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.35),
                            blurRadius: 20, offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Center(child: Text('📦', style: TextStyle(fontSize: 26))),
                    ),
                    const SizedBox(height: 16),
                    Text('Connexion', style: TextStyle(
                      fontFamily: 'DMSans', fontSize: 22, fontWeight: FontWeight.w800,
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    )),
                    const SizedBox(height: 4),
                    Text('Accédez à votre espace de travail', style: TextStyle(
                      fontFamily: 'DMSans', fontSize: 13,
                      color: isDark ? AppColors.darkText3 : AppColors.lightText3,
                    )),
                    const SizedBox(height: 32),

                    // ── Carte formulaire ──────────────────────
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkSurface1 : AppColors.lightSurface1,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Site dropdown ──────────────────
                          _FieldLabel('Site / Magasin', isDark),
                          const SizedBox(height: 6),
                          _SiteDropdown(
                            sites:        auth.sites,
                            isLoading:    auth.sitesLoading,
                            selected:     _selectedSite,
                            isDark:       isDark,
                            onChanged:    (s) => setState(() => _selectedSite = s),
                          ),
                          const SizedBox(height: 14),

                          // ── Email ──────────────────────────
                          _FieldLabel('Adresse e-mail', isDark),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller:   _emailCtrl,
                            validator:    Validators.email,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect:  false,
                            style: TextStyle(
                              fontFamily: 'DMSans', fontSize: 14,
                              color: isDark ? AppColors.darkText : AppColors.lightText,
                            ),
                            decoration: InputDecoration(
                              hintText:   'exemple@nethastock.com',
                              prefixIcon: const Icon(Icons.email_outlined, size: 18),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // ── Mot de passe ───────────────────
                          _FieldLabel('Mot de passe', isDark),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller:  _passCtrl,
                            validator:   Validators.password,
                            obscureText: _obscure,
                            style: TextStyle(
                              fontFamily: 'DMSans', fontSize: 14,
                              color: isDark ? AppColors.darkText : AppColors.lightText,
                            ),
                            decoration: InputDecoration(
                              hintText:   '••••••••',
                              prefixIcon: const Icon(Icons.lock_outline, size: 18),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                  size: 18,
                                ),
                                onPressed: () => setState(() => _obscure = !_obscure),
                              ),
                            ),
                          ),

                          // ── Erreur API ─────────────────────
                          if (auth.error != null) ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.red.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.red.withValues(alpha: 0.3)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.error_outline, color: AppColors.red, size: 16),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(auth.error!, style: const TextStyle(
                                    fontFamily: 'DMSans', fontSize: 12, color: AppColors.red,
                                  ))),
                                ],
                              ),
                            ),
                          ],

                          const SizedBox(height: 20),

                          // ── Bouton connexion ───────────────
                          AppButton(
                            label:     'Se connecter',
                            isLoading: auth.isLoading,
                            onPressed: _submit,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    Text('Version 1.0.0 · NethaStock MVP', style: TextStyle(
                      fontFamily: 'DMSans', fontSize: 11,
                      color: isDark ? AppColors.darkText3 : AppColors.lightText3,
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Widgets internes ─────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String text;
  final bool isDark;
  const _FieldLabel(this.text, this.isDark);

  @override
  Widget build(BuildContext context) => Text(text, style: TextStyle(
    fontFamily: 'DMSans', fontSize: 12, fontWeight: FontWeight.w600,
    color: isDark ? AppColors.darkText2 : AppColors.lightText2,
  ));
}

class _SiteDropdown extends StatelessWidget {
  final List<SiteModel> sites;
  final bool isLoading;
  final SiteModel? selected;
  final bool isDark;
  final ValueChanged<SiteModel?> onChanged;

  const _SiteDropdown({
    required this.sites,
    required this.isLoading,
    required this.selected,
    required this.isDark,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bg     = isDark ? AppColors.darkSurface2 : AppColors.lightSurface2;
    final border = isDark ? AppColors.darkBorder    : AppColors.lightBorder;
    final hint   = isDark ? AppColors.darkText3     : AppColors.lightText3;
    final text   = isDark ? AppColors.darkText      : AppColors.lightText;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: isLoading
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Row(children: [
                SizedBox(width: 16, height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary)),
                SizedBox(width: 10),
                Text('Chargement des sites...', style: TextStyle(
                  fontFamily: 'DMSans', fontSize: 13, color: AppColors.darkText3,
                )),
              ]),
            )
          : DropdownButtonHideUnderline(
              child: DropdownButton<SiteModel>(
                value:       selected,
                isExpanded:  true,
                dropdownColor: isDark ? AppColors.darkSurface2 : AppColors.lightSurface2,
                hint: Row(children: [
                  const Icon(Icons.store_outlined, size: 18, color: AppColors.darkText3),
                  const SizedBox(width: 10),
                  Text('Sélectionner un site...', style: TextStyle(
                    fontFamily: 'DMSans', fontSize: 14, color: hint,
                  )),
                ]),
                items: sites.map((s) => DropdownMenuItem(
                  value: s,
                  child: Row(children: [
                    const Icon(Icons.store_outlined, size: 16, color: AppColors.cyan),
                    const SizedBox(width: 10),
                    Expanded(child: Text(s.name, style: TextStyle(
                      fontFamily: 'DMSans', fontSize: 14, color: text,
                    ), overflow: TextOverflow.ellipsis)),
                    if (s.city != null)
                      Text(s.city!, style: const TextStyle(
                        fontFamily: 'DMSans', fontSize: 11, color: AppColors.darkText3,
                      )),
                  ]),
                )).toList(),
                onChanged: onChanged,
              ),
            ),
    );
  }
}
