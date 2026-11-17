// The subset of V syntax read by the PHP binding generator.
module syntax

pub struct File {
pub:
	module_name string
	stmts       []Stmt
}

pub struct Attr {
pub:
	name          string
	arg           string
	call_name     string
	call_arg_name string
	has_arg       bool
}

pub fn find_attr(attrs []Attr, name string) ?Attr {
	for attr in attrs {
		if attr.name == name {
			return attr
		}
	}
	return none
}

pub struct Table {
mut:
	symbols map[string]Symbol
}

pub fn new_table() &Table {
	return &Table{}
}

pub fn (t &Table) find_sym(name string) ?Symbol {
	return t.symbols[name]
}

pub fn (t &Table) get_type_name(typ string) string {
	return typ.trim_left('?!&')
}

pub fn (t &Table) type_to_str(typ string) string {
	return typ.replace('fn(', 'fn (')
}

enum SymbolKind {
	struct_
	enum
	sum_type
}

pub type SymbolInfo = Struct | SumType

pub struct Symbol {
pub:
	kind SymbolKind
	info SymbolInfo
}

pub struct SumType {
pub:
	variants []string
}

pub struct Struct {
pub:
	fields []Field
}

pub type Stmt = AssignStmt
	| Block
	| ConstDecl
	| EnumDecl
	| ExprStmt
	| FnDecl
	| InterfaceDecl
	| Return
	| StructDecl
	| Unknown

pub type Expr = ArrayLiteral
	| BoolLiteral
	| CallExpr
	| CastExpr
	| FloatLiteral
	| Ident
	| IfExpr
	| IfGuardExpr
	| IntegerLiteral
	| MapInit
	| MatchExpr
	| ParExpr
	| PrefixExpr
	| SelectorExpr
	| StringLiteral
	| StructInit
	| Unknown
	| UnsafeExpr

pub struct Unknown {}

pub struct ArrayLiteral {
pub:
	values []Expr
}

pub struct Param {
pub:
	name string
	typ  string
}

pub struct FnDecl {
pub:
	name                  string
	attrs                 []Attr
	params                []Param
	return_type           string
	receiver              Param
	stmts                 []Stmt
	is_method             bool
	is_static_type_method bool
	is_pub                bool
	is_noreturn           bool
	is_variadic           bool
}

pub struct StructDecl {
pub:
	name             string
	attrs            []Attr
	fields           []Field
	embeds           []Param
	implements_types []Param
	is_implements    bool
}

pub struct Field {
pub:
	name             string
	typ              string
	attrs            []Attr
	comments         []Comment
	is_pub           bool
	is_mut           bool
	has_default_expr bool
	default_expr     Expr
}

pub struct Comment {
pub:
	text string
}

pub struct InterfaceDecl {
pub:
	name    string
	attrs   []Attr
	methods []FnDecl
}

pub struct EnumDecl {
pub:
	name   string
	attrs  []Attr
	fields []ValueField
}

pub struct ConstDecl {
pub:
	attrs  []Attr
	fields []ValueField
}

pub struct ValueField {
pub:
	name     string
	expr     Expr
	has_expr bool
}

pub struct Block {
pub:
	stmts []Stmt
}

pub struct Return {
pub:
	exprs []Expr
}

pub struct ExprStmt {
pub:
	expr Expr
}

pub struct AssignStmt {
pub:
	left  []Expr
	right []Expr
}

pub struct StringLiteral {
pub:
	val string
}

pub struct IntegerLiteral {
pub:
	val string
}

pub struct FloatLiteral {
pub:
	val string
}

pub struct BoolLiteral {
pub:
	val bool
}

pub struct Ident {
pub:
	name string
}

pub struct SelectorExpr {
pub:
	expr       &Expr
	field_name string
}

pub struct ParExpr {
pub:
	expr &Expr
}

pub struct UnsafeExpr {
pub:
	expr &Expr
}

pub struct CastExpr {
pub:
	expr &Expr
}

pub enum PrefixOp {
	other
	minus
	amp
}

pub struct PrefixExpr {
pub:
	op    PrefixOp
	right &Expr
}

pub struct StructInit {
pub:
	typ         string
	init_fields []ValueField
}

pub struct MapInit {
pub:
	keys []Expr
	vals []Expr
}

pub struct Branch {
pub:
	cond  Expr
	stmts []Stmt
}

pub struct IfExpr {
pub:
	branches []Branch
	has_else bool
}

pub struct MatchExpr {
pub:
	branches []Branch
}

pub struct IfGuardExpr {
pub:
	vars []Ident
	expr &Expr
}

pub struct CallExpr {
pub:
	name     string
	left     &Expr
	args     []CallArg
	or_block Block
}

pub struct CallArg {
pub:
	expr Expr
}

pub fn (s SelectorExpr) root_ident() ?Ident {
	mut root := *s.expr
	for root is SelectorExpr {
		root = *(root as SelectorExpr).expr
	}
	if root is Ident {
		return root as Ident
	}
	return none
}
